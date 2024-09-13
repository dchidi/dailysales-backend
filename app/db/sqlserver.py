from fastapi import Depends
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, Session
from app.core.config import Settings
from app.utils.test_sqlserver_db_connection import test_connection

settings = Settings()

class SQLServerConnection:
    def __init__(self, server_url: str):
        self.engine = create_engine(server_url)
        # verify connection
        # test_connection(self.engine)
        self.SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=self.engine)
    
    def get_session(self) -> Session:
        session = self.SessionLocal()
        try:
            yield session
        finally:
            session.close()

# Instantiate connection handlers for each SQL Server database
au_uts = SQLServerConnection(settings.sql_server_uts_url_au)
au_fit = SQLServerConnection(settings.sql_server_fit_url_au)

nz_uts = SQLServerConnection(settings.sql_server_uts_url_nz)
nz_fit = SQLServerConnection(settings.sql_server_fit_url_nz)

at_uts = SQLServerConnection(settings.sql_server_uts_url_at)
de_uts = SQLServerConnection(settings.sql_server_uts_url_de)
uk_uts = SQLServerConnection(settings.sql_server_uts_url_uk)

print("Connections created")

# Connection sessions
def get_au_uts_session(session: Session = Depends(au_uts.get_session)) -> Session:
    return session

def get_au_fit_session(session: Session = Depends(au_fit.get_session)) -> Session:
    return session

def get_nz_uts_session(session: Session = Depends(nz_uts.get_session)) -> Session:
    return session

def get_nz_fit_session(session: Session = Depends(nz_fit.get_session)) -> Session:
    return session

def get_at_uts_session(session: Session = Depends(at_uts.get_session)) -> Session:
    return session

def get_de_uts_session(session: Session = Depends(de_uts.get_session)) -> Session:
    return session

def get_uk_uts_session(session: Session = Depends(uk_uts.get_session)) -> Session:
    return session