# imagen liviana de python
FROM python:3.12-slim

WORKDIR /app

# primero se copian los requirements para aprovechar la cache de docker:
# si solo cambia app.py no se vuelven a instalar las dependencias
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

# documenta que flask escucha en el 5000 (no lo publica al host)
EXPOSE 5000

CMD ["python", "app.py"]
