from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def root():
    return {
        "message": "Привет, преподаватель!",
        "student": "Лазарев_Давид",
        "group": "21_к_ас_1",
        "project": "Secure Service",
        "status": "running"
    }

@app.get("/health")
def health():
    return {"status": "ok"}