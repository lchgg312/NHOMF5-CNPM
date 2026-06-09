from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# Thay root:123456 bằng username và mật khẩu của bạn
SQLALCHEMY_DATABASE_URL = "mysql+mysqlconnector://root:123456@localhost:3306/pharma_db"

engine = create_engine(SQLALCHEMY_DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

# Hàm lấy kết nối CSDL
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()