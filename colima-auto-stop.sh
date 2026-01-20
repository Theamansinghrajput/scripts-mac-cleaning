#!/bin/bash

if ! docker ps --format '{{.ID}}' | grep -q .; then
  echo "No running containers. Stopping Colima..."
  colima stop
fi
