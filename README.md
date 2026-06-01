# Лабораторная работа: «Технология проектирования автоматизированных систем в защищённом исполнении»

**Выполнил:** Лазарев Давид  
**Группа:** 21-К-АС-1  

---

## Задание
Разработать защищённый веб-сервис на FastAPI, упаковать в Docker, развернуть в Яндекс Облаке (ВМ) и в локальном Minikube.

---

## Результаты

### 1. GitHub репозиторий
[https://github.com/DAVID704456/fastapi-secure-lab](https://github.com/DAVID704456/fastapi-secure-lab)

### 2. Сервис в Яндекс Облаке (НА ДАННЫЙ МОМЕНТ ОТКЛЮЧЕН И ИМЕЕТ ДИНАМИЧЕСКИЙ АЙПИ)
- **Публичный IP:** `81.26.178.108`
- **Порт:** `80`
- **Ссылка для проверки:** [http://81.26.178.108](http://81.26.178.108)

Сервис возвращает JSON с именем студента и группой.

### 3. Сервис в Minikube
- Локальный кластер запущен, поды в статусе `Running`.
- Доступ через `kubectl port-forward` на порт `8888`.
- 
4. Yandex Cloud (Terraform)
bash
cd terraform
terraform init
terraform apply -auto-approve
После выполнения terraform apply будет выведен публичный IP-адрес виртуальной машины. Сервис будет доступен по адресу: http://<IP>:80
---

## Скриншоты выполнения
Все скриншоты находятся в папке:  
[`screenshots_lab_lazarev`](https://github.com/DAVID704456/fastapi-secure-lab/tree/main/screenshots_lab_lazarev)  


В папке содержатся следующие документы:
- Локальный запуск сервиса
- GitHub Actions (успешный билд)
- Проверка curl на ВМ в Яндекс Облаке
- Поды в Minikube (Running)
- Доступ к сервису в Minikube через порт-форвард

---

## Инструкция по развёртыванию

### Требования
- Установленные: Git, Docker, Minikube, kubectl, Python 3.10+.

### 1. Клонирование репозитория
```bash
git clone https://github.com/DAVID704456/fastapi-secure-lab.git
cd fastapi-secure-lab/secure-app
2. Локальный запуск (без Docker)
bash
pip install -r requirements.txt
uvicorn app.main:app --reload
Открыть в браузере: http://localhost:8000

3. Сборка Docker-образа и запуск контейнера
bash
docker build -t fastapi-secure .
docker run -d -p 8000:8000 fastapi-secure
Проверить: curl http://localhost:8000

4. Развёртывание в Minikube
bash
minikube start --driver=docker
minikube image load fastapi-secure
kubectl apply -f k8s/
kubectl port-forward -n secure-ns service/fastapi-svc 8888:80
Открыть в браузере: http://localhost:8888

5. Развёртывание в Яндекс Облаке
Создана виртуальная машина на базе Ubuntu 22.04.

Установлен Docker, склонирован репозиторий.

Собран образ и запущен контейнер:

bash
docker build -t fastapi-secure .
docker run -d -p 80:8000 fastapi-secure
Публичный IP: 81.26.178.108. Сервис доступен по адресу http://81.26.178.108.

Проверка работы
Яндекс Облако (вывод curl с самой ВМ)
json
{"message":"Привет, преподаватель!","student":"Лазарев Давид","group":"21_k_ac_1","project":"Secure Service","status":"running"}
Minikube (статус подов)
text
NAME                           READY   STATUS    RESTARTS   AGE
fastapi-dep-565fc688fd-2r74n   1/1     Running   0          3m33s
fastapi-dep-565fc688fd-g59xm   1/1     Running   0          3m33s
Примечание
Если адрес http://81.26.178.108 не открывается в вашем браузере, это может быть связано с блокировкой порта 80 вашим интернет-провайдером. Сервис работает штатно, что подтверждается выводом curl с самой виртуальной машины (скриншот приложен)

Ссылки
GitHub репозиторий
Сервис в Яндекс Облаке
