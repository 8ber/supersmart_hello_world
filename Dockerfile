FROM python:3-alpine
RUN pip install flask
COPY hello_world.py ./
EXPOSE 3000
CMD [ "python", "./hello_world.py" ]