from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI(title="Signal Validation API")

# Gelecek verinin şeması
class SignalPayload(BaseModel):
    signal_id: str
    frequency: float
    is_encrypted: bool

@app.post("/validate")
def validate_signal(payload: SignalPayload):
    # Basit bir doğrulama simülasyonu
    if payload.frequency < 10.0 or not payload.is_encrypted:
        return {"status": "rejected", "reason": "Unsafe or unencrypted signal detected"}
    
    return {"status": "verified", "signal_id": payload.signal_id}

@app.get("/health")
def health_check():
    # Jenkins ve K8s uygulamanın çöküp çökmediğini buraya istek atarak anlayacak
    return {"status": "healthy"}    