import random, time, logging

from fastapi import FastAPI
from opentelemetry import trace

app = FastAPI()
tracer = trace.get_tracer(__name__)


@app.get("/health")
def health_check():
    return {
        "status": "healthy",
    }


@app.get("/roll")
@tracer.start_as_current_span("roll_a_dice")
def roll_dice():
    logging.info("Rolling a dice...")

    with tracer.start_as_current_span("simulate_delay") as span:
        time.sleep(random.uniform(0.01, 0.05))
        result = random.randint(1, 6)
        span.set_attribute("dice.result", result)

    logging.info(f"Rolled a {result}")

    return {
        "message": f"rolled a {result}",
    }
