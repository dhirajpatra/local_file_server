#!/bin/bash

# Check if USB HDD is already mounted
MOUNT_POINT="/media/usb_hdd"
DEVICE="/dev/sdb3"  # Update this with the correct device name

if mount | grep "on $MOUNT_POINT type" > /dev/null; then
  echo "USB HDD is already mounted on $MOUNT_POINT. Unmounting..."
  sudo umount $MOUNT_POINT
  
  # Check if unmount was successful
  if [ $? -eq 0 ]; then
    echo "USB HDD unmounted successfully from $MOUNT_POINT"
  else
    echo "Unmount failed. Please check USB drive and permissions."
    exit 1
  fi
fi

# Mount USB HDD
sudo mount $DEVICE $MOUNT_POINT

# Check if mount was successful
if [ $? -eq 0 ]; then
  echo "USB HDD mounted successfully to $MOUNT_POINT"
else
  echo "Mount failed. Please check USB drive and permissions."
  exit 1
fi

# Install pip libraries (optional)
# pip install -r requirements.txt

# Run Uvicorn on all network interfaces (0.0.0.0) to allow access from other devices
uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload &

# Capture Uvicorn's process ID
UVICORN_PID=$!

# Unmount USB HDD on script termination
trap "sudo umount $MOUNT_POINT; kill $UVICORN_PID" EXIT

# Wait for Uvicorn process to end
wait $UVICORN_PID

# Additional checks and improvements:
# - Check if Uvicorn started successfully
if [ $? -eq 0 ]; then
  echo "Uvicorn started successfully"
else
  echo "Uvicorn failed to start"
  exit 1
fi

# - Add error handling for pip install
# - Consider using a virtual environment
# - Implement logging for troubleshooting
# - Provide more informative error messages
