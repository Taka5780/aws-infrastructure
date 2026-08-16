from fastapi import FastAPI

app = FastAPI()


@app.get("/health")
def vitality_monitoring():
    return {"health": "OK"}


@app.get("/version")
def check_version():
    return {"version": "1.1"}
