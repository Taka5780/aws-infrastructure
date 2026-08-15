from fastapi.testclient import TestClient
from main import app

client = TestClient(app)


def test_health():
    response = client.get("/health")

    assert response.status_code == 200
    assert response.json() == {"health": "OK"}


def test_version():
    response = client.get("/version")

    assert response.status_code == 200
    assert response.json() == {"version": "1.0"}
