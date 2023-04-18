FROM python:3-alpine

COPY hello_world.py ./

CMD [ "python", "-u", "./hello_world.py" ]