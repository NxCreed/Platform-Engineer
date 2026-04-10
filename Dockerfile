FROM nginx:latest
RUN apt-get update && apt-get upgrade -y && apt-get install -y openssl libssl3t64
# Απλώς αλλάζουμε το index page για να ξέρουμε ότι είναι το ΔΙΚΟ ΜΑΣ image
RUN echo "<h1>Hello from CI/CD Pipeline!</h1>" > /usr/share/nginx/html/index.html