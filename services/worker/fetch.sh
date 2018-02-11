ID=$1
echo "fetch $1"

curl -s  "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucleotide&id=${ID}&rettype=gb&retmode=txt">$ID.gbk
