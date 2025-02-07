# Etapa de construcción para Angular
FROM node:18 AS build

# Directorio de trabajo
WORKDIR /app

# Copiar package.json y package-lock.json
COPY package*.json ./

# Instalar dependencias de Angular
RUN npm install

# Copiar el código fuente de Angular
COPY . .

# Construir el proyecto Angular
RUN npm run build --prod

# Etapa de producción para Flask
FROM python:3.9-slim AS flask

# Instalar dependencias para Flask
WORKDIR /app

# Copiar el archivo de requerimientos de Flask
COPY requirements.txt .

# Instalar las dependencias de Flask
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el código fuente de Flask
COPY . .

# Copiar los archivos estáticos de Angular desde la etapa de construcción
COPY --from=build /app/dist/ /app/static/

# Exponer el puerto de Flask
EXPOSE 5000

# Comando para ejecutar Flask
CMD ["python", "app.py","--host=0.0.0.0"]
