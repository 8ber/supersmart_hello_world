FROM python:3-slim

COPY hello_world.py ./

CMD [ "python", "./hello_world.py" ]