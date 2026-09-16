import pubsub

class WaterVapor(Exception):
    pass

def handle(rain):
    raise WaterVapor()

def soil():
    pubsub.subscribe('rain', handle)
