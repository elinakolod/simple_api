JWTSessions.algorithm = 'HS256'
JWTSessions.encryption_key = Rails.application.credentials.jwt[:secret_jwt_encryption_key]