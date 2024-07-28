console.log("Hello from File Server!");

document.getElementById('uploadForm').onsubmit = async function(event) {
    event.preventDefault();
    const formData = new FormData(event.target);
    const response = await fetch('/uploadfile/', {
        method: 'POST',
        body: formData
    });
    if (response.ok) {
        document.getElementById('message').textContent = 'File uploaded successfully!';
        document.getElementById('uploadForm').reset();
        setTimeout(() => {
            window.location.reload();
        }, 1000);
    } else {
        document.getElementById('message').textContent = 'File upload failed.';
    }
};
