from enum import IntEnum

class MSG_TYPE(IntEnum):
    INFO = 0
    ERROR = 10
    GPS = 20
    EVENT_GENERATED = 30
    EVENT_RECEIVED = 40
    VEHICLE_STOPPED = 50
    VEHICLE_RELEASED = 60
    CONFIGURATION_RECEIVED = 70
    CONFIGURATION_SENT = 80
