# Χρησιμοποιούμε το unprivileged image για να μην έχουμε CrashLoopBackOff στο Kubernetes
FROM nginxinc/nginx-unprivileged:stable-alpine

# Αν έχεις κάποιο index.html, το αντιγράφεις έτσι:
# COPY index.html /usr/share/nginx/html/

# Ο unprivileged nginx ακούει αυτόματα στην 8080
EXPOSE 8080