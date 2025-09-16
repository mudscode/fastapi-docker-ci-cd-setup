from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()
app.title = "Trying docker with fastapi"

@app.get("/")
def read_root():
    return {"Hello from the other side!"}

@app.get("/items/{item_id}")
def read_item(item_id: int, q: str = None):
    return {"item_id": item_id, "q": q}

# Add this to your main FastAPI file (probably app.py)
@app.get("/health") 
def health_check():
    return {"status": "healthy", "message": "FastAPI is running!"}