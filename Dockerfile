# Etapa 1: Construir la aplicación
FROM node:18-alpine AS build

WORKDIR /app
COPY . .

# Instalar dependencias de desarrollo y construir la aplicación
RUN yarn install

# Etapa 2: Empaquetar la aplicación en una imagen más liviana
FROM node:18-alpine

WORKDIR /app

# Copiar solo los archivos necesarios de la etapa de construcción
COPY --from=build /app .

# Instalar solo las dependencias de producción
RUN yarn install --production

# Exponer el puerto
EXPOSE 3000

# Comando para ejecutar la aplicación
CMD ["node", "src/index.js"]
