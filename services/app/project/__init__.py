# users/project/__init__.py
import os

from flask import Flask


def create_app():

    # instantiate the app
    app = Flask(__name__)

    # set config
    app_settings = os.getenv('APP_SETTINGS')
    app.config.from_object(app_settings)

    # register blueprints
    # from project.api.users import users_blueprint
    # app.register_blueprint(users_blueprint)

    return app
