FROM bitnami/spark:3.5.1

WORKDIR /app    

COPY spark-requirements.txt requirements.txt

RUN pip install -r requirements.txt
