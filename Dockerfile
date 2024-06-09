FROM public.ecr.aws/lts/ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/New_York
# Install any necessary packages
RUN apt-get update && \
    apt-get install -y pkg-config build-essential python3-dev libpq-dev libssl-dev libffi-dev weasyprint  python3-pip python3-testresources python3-wheel && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory to /app
WORKDIR ~/

# Copy the rest of the application code to the container
COPY . .



RUN pip3 install -r requirements.txt

# Expose the port that the application listens on
EXPOSE 8000

# Start the server
CMD ["sh", "-c", "uvicorn src.main:app --host 0.0.0.0 --port 8000"]