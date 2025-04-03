# Imagen base con Python
FROM python:3.12

# Instalar dependencias del sistema (Java para Spark y paquetes para gráficos)
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk-headless && \
    apt-get clean

RUN apt-get clean

# Copiar todo el proyecto
COPY requirements.txt .

# Instalar dependencias de Python
RUN pip install -r requirements.txt

## Traigo el spark
RUN wget -q https://archive.apache.org/dist/spark/spark-3.4.1/spark-3.4.1-bin-hadoop3.tgz && \
    tar -xvf spark-3.4.1-bin-hadoop3.tgz && \
    mv spark-3.4.1-bin-hadoop3 /opt/spark && \
    rm spark-3.4.1-bin-hadoop3.tgz

# Variables de entorno para Java y Spark
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Puerto para Jupyter
EXPOSE 8888

# Comando para iniciar 
CMD ["/bin/bash"]