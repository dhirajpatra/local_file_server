import os
from fastapi import FastAPI, File, UploadFile, Request
from fastapi.responses import RedirectResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates
import re

# Initialize FastAPI app
app = FastAPI()

# Configure Jinja2 templates directory
templates = Jinja2Templates(directory="app/templates")

# Define upload directory for uploaded files
UPLOAD_DIRECTORY = "/media/usb_hdd/share"

# Function to sanitize filenames
def escape_filename(filename: str) -> str:
    # Remove any special characters and spaces, allow only alphanumeric, dashes, and underscores
    sanitized_filename = re.sub(r'[^a-zA-Z0-9_\-\.]', '_', filename)
    return sanitized_filename

# Upload file endpoint
@app.post("/uploadfile/")
async def create_file(upload_file: UploadFile = File(...)):
    # Create file path with proper filename escaping
    file_path = os.path.join(UPLOAD_DIRECTORY, escape_filename(upload_file.filename))
    
    with open(file_path, "wb") as buffer:
        buffer.write(await upload_file.read())
    
    # Redirect back to the upload page
    return RedirectResponse(url="/", status_code=303)

# Root route to list files and serve index.html
@app.get("/")
async def index(request: Request):
    files = os.listdir(UPLOAD_DIRECTORY)
    files = [f for f in files if os.path.isfile(os.path.join(UPLOAD_DIRECTORY, f))]
    return templates.TemplateResponse("index.html", {"request": request, "files": files})

# Serve static files from the "static" directory
app.mount("/app/static", StaticFiles(directory="app/static"), name="static")
