from flask import Blueprint, render_template

main = Blueprint('main', __name__)

@main.route('/')
def home():
    return render_template('index.html')

@main.route('/about')
def about():
    return render_template('about.html')

@main.route('/quotes')
def quotes():
    return render_template('quotes.html')

@main.route('/blog')
def blog():
    return render_template('blog.html')

@main.route('/contact')
def contact():
    return render_template('contact.html')
