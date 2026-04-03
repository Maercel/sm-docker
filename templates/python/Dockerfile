FROM python:3.11.15-trixie

WORKDIR /usr/src/python

COPY . . 
RUN pip install --no-cache-dir -r requirements.txt || true 


CMD ["python", "-u", "run.py"]