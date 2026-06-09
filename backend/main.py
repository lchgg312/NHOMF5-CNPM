from fastapi import FastAPI, Depends, HTTPException, status, Query
from sqlalchemy.orm import Session
import bcrypt
import models, database
from pydantic import BaseModel
from typing import List, Optional

app = FastAPI(title="Pharma Lookup API")

# --- HÀM BẢO MẬT (Giữ nguyên) ---
def get_password_hash(password: str) -> str:
    pwd_bytes = password[:72].encode('utf-8')
    return bcrypt.hashpw(pwd_bytes, bcrypt.gensalt()).decode('utf-8')

def verify_password(plain_password: str, hashed_password: str) -> bool:
    try:
        pwd_bytes = plain_password[:72].encode('utf-8')
        return bcrypt.checkpw(pwd_bytes, hashed_password.encode('utf-8'))
    except Exception:
        return False

# --- SCHEMA DỮ LIỆU ---
class UserCreate(BaseModel):
    full_name: str
    email: str
    password: str

class UserLogin(BaseModel):
    email: str
    password: str

class MedicineSchema(BaseModel):
    id: int
    name: str
    # Bổ sung các trường nếu models của bạn có, ví dụ:
    # description: Optional[str] = None

    class Config:
        from_attributes = True

# --- API ENDPOINTS ---

# 1. Đăng ký (Giữ nguyên)
@app.post("/register", status_code=status.HTTP_201_CREATED)
def register(user: UserCreate, db: Session = Depends(database.get_db)):
    if db.query(models.User).filter(models.User.email == user.email).first():
        raise HTTPException(status_code=400, detail="Email đã được đăng ký")

    hashed_pw = get_password_hash(user.password)
    new_user = models.User(full_name=user.full_name, email=user.email, hashed_password=hashed_pw)
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    return {"message": "Đăng ký thành công!"}

# 2. Đăng nhập (Giữ nguyên)
@app.post("/login")
def login(user: UserLogin, db: Session = Depends(database.get_db)):
    db_user = db.query(models.User).filter(models.User.email == user.email).first()
    if not db_user or not verify_password(user.password, db_user.hashed_password):
        raise HTTPException(status_code=401, detail="Email hoặc mật khẩu không chính xác")
    return {"message": "Đăng nhập thành công!", "user_id": db_user.id}

# 3. Tra cứu và lấy danh sách thuốc (Bổ sung phân trang)
@app.get("/medicines/", response_model=List[MedicineSchema])
def get_medicines(
    q: Optional[str] = None,
    skip: int = 0,
    limit: int = 20,
    db: Session = Depends(database.get_db)
):
    query = db.query(models.Medicine)

    # Nếu có từ khóa tìm kiếm
    if q:
        query = query.filter(models.Medicine.name.contains(q))

    # Phân trang
    results = query.offset(skip).limit(limit).all()
    return results