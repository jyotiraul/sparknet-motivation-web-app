# Motivation Flask App

## Overview
The Motivation Flask App is a web application designed to uplift and inspire individuals with motivational quotes, articles, and a contact form. This application is built using the Flask framework and follows a structured design pattern.

## Project Structure
```
motivation-web-app
├── app
│   ├── __init__.py
│   ├── routes.py
│   ├── templates
│   │   ├── base.html
│   │   ├── index.html
│   │   ├── about.html
│   │   ├── quotes.html
│   │   ├── blog.html
│   │   └── contact.html
│   └── static
│       ├── css
│       │   └── styles.css
│       └── js
├── requirements.txt
├── run.py
└── README.md
```

## Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone https://github.com/sparknet-innovations/motivation-web-app.git
   cd motivation-web-app
   ```

2. **Create a Virtual Environment**
   ```bash
   python -m venv venv
   ```

3. **Activate the Virtual Environment**
   - On Windows:
     ```bash
     venv\Scripts\activate
     ```
   - On macOS/Linux:
     ```bash
     source venv/bin/activate
     ```

4. **Install Dependencies**
   ```bash
   pip install -r requirements.txt
   ```

5. **Run the Application**
   ```bash
   python run.py
   ```

6. **Access the Application**
   Open your web browser and go to `http://127.0.0.1:5000`.

## Features
- Home page with a motivational quote.
- About page detailing the purpose of the application.
- Quotes page displaying a list of motivational quotes.
- Blog page with articles on motivation.
- Contact page with a form for user inquiries.

