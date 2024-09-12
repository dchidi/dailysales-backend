from fastapi import Depends
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, Session
from app.core.config import Settings
from app.utils.test_sqlserver_db_connection import test_connection

settings = Settings()
engine_sqlserver = create_engine(settings.au_sql_server_url)
au_uts_sql_engine = create_engine(settings.au_uts_sql_server_url)

# verify connection
# test_connection(engine_sqlserver)

SessionLocalSQLServer = sessionmaker(
    autocommit=False, autoflush=False, bind=engine_sqlserver
)

AU_UTS_SESSION = sessionmaker(
    autocommit=False, autoflush=False, bind=au_uts_sql_engine
)


def get_sqlserver_db():
    db = SessionLocalSQLServer()
    try:
        yield db
    finally:
        db.close()

def get_au_uts_sqlserver(session: Session = Depends(AU_UTS_SESSION)) -> Session:
    try:
        yield session
    finally:
        session.close()