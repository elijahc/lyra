import redis
import requests
import json
import time
import os
from Bio import SeqIO
from kamikaze.mutagenesis import AlanineScan
from kamikaze.datasets import kras

JOB_Q = RUN_Q = None

class Worker():
    def __init__(self,job_id,region_start,region_stop,lib_name,sp_primer,sg_promoter,**kwargs):
        self.job_id = job_id
        # self.filename = filename
        self.region = slice(int(region_start),int(region_stop))
        self.lib_name = lib_name
        self.sp_primer = sp_primer
        self.sg_promoter = sg_promoter

    def do_job(self):
        # parse job
        print("starting job ",self.job_id)
        fp = kras()
        fp = '/Users/elijahc/dev/kamikaze/kamikaze/data/kras_mrna_va.fa'
        self.factory = AlanineScan(filename=fp,region=self.region,ha_margins='60',lib_name=self.lib_name)
        self.output = self.factory.assemble_oligos(sp_primer=self.sp_primer,sg_promoter=self.sg_promoter)
        out_fp = os.path.join('.','data','output',str(self.job_id)+".fa")
        SeqIO.write(self.output, out_fp, "fasta")
        self.status = 'finished'

        print('finished job!')

    def to_json(self):
        out ={}
        out['id'] = self.job_id
        out['lib_name'] = self.lib_name
        out['sp_primer'] = self.sp_primer
        out['sg_promoter'] = self.sg_promoter
        out['region_start'] = self.region.start
        out['region_stop'] = self.region.stop
        out['status'] = self.status
        return json.dumps(out)


while True:
    time.sleep(2)
    jobs = requests.get('http://localhost:9292/jobs').json()
    njobs = len(jobs)

    print(njobs)
    if False:
        # import ipdb; ipdb.set_trace()
        try:
            job_id = redis_db.rpoplpush(JOB_Q,RUN_Q)
            print(job_id)
            job_str = redis_db.hget(STATUS,job_id)
            job = json.loads(job_str)
            job['job_id']=job.pop('id')
            worker = Worker(**job)
            print('starting job')
            worker.status = 'running'
            redis_db.hset(STATUS,worker.job_id,worker.to_json())
            worker.do_job()
            redis_db.hset(STATUS,worker.job_id,worker.to_json())
            redis_db.rpoplpush(RUN_Q,FINISHED_Q)

        except KeyboardInterrupt:
            raise
        except ValueError:
            print('Bad job, discarding')
            import ipdb; ipdb.set_trace()
            print('returning to watching queue')    
        except:
            print('Crashed, returning job to queue...')
            redis_db.lpush(JOB_Q,job_id)
            raise
