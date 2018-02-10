# services/users/project/api/users.py


from flask import Blueprint, jsonify, request, render_template

# from project.api.models import User
# from project import db
# from project.api.utils import authenticate, is_admin

users_blueprint = Blueprint('users', __name__, template_folder='./templates')


@users_blueprint.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        username = request.form['username']
        email = request.form['email']
        password = request.form['password']
        db.session.add(User(username=username, email=email, password=password))
        db.session.commit()
    return render_template('index.html', users=users)


@users_blueprint.route('/ping', methods=['GET'])
def ping_pong():
    return jsonify({
        'status': 'success',
        'message': 'pong!'
    })
