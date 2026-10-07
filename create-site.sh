#!/usr/bin/env bash
# Генератор/проверка структуры сайта РЕЗМЕТАЛЛ
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

required=(
  index.html
  services.html
  projects.html
  about.html
  contacts.html
  css/styles.css
  js/main.js
)

echo "РЕЗМЕТАЛЛ — проверка файлов сайта"
missing=0
for f in "${required[@]}"; do
  if [[ -f "$f" ]]; then
    echo "  ✓ $f"
  else
    echo "  ✗ отсутствует: $f"
    missing=1
  fi
done

if [[ "$missing" -ne 0 ]]; then
  echo "Ошибка: не хватает файлов."
  exit 1
fi

PORT="${PORT:-4173}"
echo
echo "Все страницы на месте."
echo "Запуск локального сервера: http://127.0.0.1:${PORT}"
echo "Остановка: Ctrl+C"
echo

if command -v python3 >/dev/null 2>&1; then
  exec python3 -m http.server "$PORT" --bind 127.0.0.1
elif command -v python >/dev/null 2>&1; then
  exec python -m http.server "$PORT" --bind 127.0.0.1
else
  echo "Установите Python или откройте index.html в браузере."
  exit 1
fi
