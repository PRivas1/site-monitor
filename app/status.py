# Checks webpages current status
import requests
from fastapi import FastAPI

app = FastAPI()

@app.get("/check-site")
def check_site(url: str):
    try:
        requests.get(url, timeout=5)
        return {"site": url, "status": "Online"}
    except:
        return {"site": url, "status": "Offline"}