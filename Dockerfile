# 1. Aşama: Temel imajı belirliyoruz. En hafif Python versiyonlarından birini seçiyoruz.
FROM python:3.10-slim

# 2. Aşama: Konteynerin içindeki çalışma klasörümüzü oluşturuyoruz.
WORKDIR /app

# 3. Aşama: Önce kütüphane listemizi kopyalıyoruz (cache avantajı için).
COPY requirements.txt .

# 4. Aşama: Kütüphaneleri konteynerin içine kuruyoruz.
RUN pip install --no-cache-dir -r requirements.txt

# 5. Aşama: Kendi yazdığımız kodları (main.py vb.) kopyalıyoruz.
COPY . .

# 6. Aşama: Uygulamamızın 8000 portundan çalışacağını belirtiyoruz.
EXPOSE 8000

# 7. Aşama: Konteyner ayağa kalktığında çalışacak o meşhur uvicorn komutu.
# "--host 0.0.0.0" kısmı çok önemli: Docker içindeki uygulamanın dış dünyaya açılmasını sağlar.
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]