# File Upload Server

This is a simple file upload server built using FastAPI, Uvicorn, and Bootstrap. The server allows users to upload files through a web interface and store them on a connected USB hard drive.

## Features

- Upload files through a web interface
- Store uploaded files on a USB hard drive
- Bootstrap-styled user interface

## Requirements

- Python 3.10+
- FastAPI
- Uvicorn
- Jinja2

## Installation

1. Clone the repository:

    ```bash
    git clone <repository-url>
    cd file_upload_server
    ```

2. Create a virtual environment and activate it:

    ```bash
    python -m venv venv
    source venv/bin/activate
    ```

3. Install the required Python packages:

    ```bash
    pip install -r requirements.txt
    ```

## Setup

1. Connect and mount your USB hard drive. Adjust the device name and mount point as needed:

    ```bash
    sudo mount /dev/sdc3 /media/usb_hdd
    ```

2. Ensure that the mount was successful:

    ```bash
    ls /media/usb_hdd
    ```

3. Update the `start.sh` script with the correct device name and mount point if necessary.

## Usage

1. Run the server:

    ```bash
    ./start.sh
    ```

2. Access the application from your browser using the server's IP address:

    ```text
    http://<your-ip-address>:8000
    ```

3. Upload files using the provided form.

## Directory Structure

```plaintext
.
├── app
│   ├── __init__.py
│   ├── main.py
│   ├── static
│   │   ├── css
│   │   │   └── styles.css
│   │   └── js
│   │       └── script.js
│   └── templates
│       └── index.html
├── requirements.txt
├── start.sh
└── README.md
