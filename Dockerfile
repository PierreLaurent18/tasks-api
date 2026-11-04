# TODO 1 : image de base Python légère
FROM python:3.12-slim

# TODO 2 : dossier de travail
WORKDIR /app

# TODO 3 : dépendances d'abord (cache), puis installation
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# TODO 4 : code de l'application
COPY . .

# TODO 5 : utilisateur non-root
RUN useradd --create-home appuser
USER appuser

# TODO 6 : version embarquée, port et démarrage
ARG APP_VERSION=dev
ENV APP_VERSION=${APP_VERSION}
EXPOSE 8000
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "app.main:app"]