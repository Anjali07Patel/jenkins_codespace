FROM python:3.8-slim

WORKDIR /usr/src/app

copy . .

CMD ["python","./program.py"]