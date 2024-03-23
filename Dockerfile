FROM python:3.9-slim
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
RUN pip install pytest
RUN pytest test_app.py
EXPOSE 6000
CMD ["python", "app.py"]

