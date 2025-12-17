
# FusionTech - ERC 2027

Oficjalne repozytorium oprogramowania łazika zespołu **FusionTech**, przygotowywanego do zawodów **European Rover Challenge (ERC)**.

Projekt wykorzystuje architekturę opartą na **ROS 2 Humble**, konteneryzacji **Docker** oraz hybrydowym podejściu do developmentu (Cross-Platform), wspierając zarówno stacje robocze (macOS/Linux/Windows), jak i komputer pokładowy NVIDIA Jetson Xavier AGX.

---

## Dokumentacja Techniczna

Ze względów bezpieczeństwa i organizacji, pełna dokumentacja techniczna, schematy oraz szczegóły znajdują się w wewnętrznych zasobach zespołu.

 **Lokalizacja Dokumentacji:**

- **Platforma:** Microsoft Teams
- **Zespół:** `System obliczeniowy-sterowania`
- **Zakładka:** Pliki (Files)
- **Folder:** `Dokumentacja`


Znajdziesz tam m.in.:

- Wdrożenie do pracy z systemem oraz githubem
- Architekturę systemu sterowania.
- Strukture GitHuba

---

##  Szybki Start (Initial Knowledge)

Dzięki konteneryzacji, **nie musisz instalować ROS 2 ani bibliotek systemowych** na swoim komputerze. Wymagane są jedynie: [Docker Desktop](https://www.docker.com/products/docker-desktop) oraz [VS Code](https://code.visualstudio.com/).

### 1. Pobierz repozytorium

```Bash
git clone git@github.com:FusionTech-ZUT/ERC-2027.git
cd ERC-2027
```

### 2. Uruchom Środowisko

Skrypt automatycznie wykryje Twój system (Mac/PC/Jetson) i zbuduje odpowiedni kontener:

```Bash
./run.sh
```

_Pierwsze uruchomienie może potrwać kilka minut (pobieranie obrazów)._

### 3. Wejdź do Systemu

Gdy zobaczysz komunikat `Gotowe`, wejdź do terminala kontenera:

```Bash
docker compose exec rover_dev bash
```

Teraz masz dostęp do pełnego środowiska ROS 2. Możesz kompilować kod (`colcon build`) i uruchamiać węzły.

---

## Struktura Projektu (Monorepo)

Kod źródłowy podzielony jest na logiczne pakiety w folderze `src/`:

- `erc_interfaces` - Wspólne definicje wiadomości (`.msg`, `.srv`).
- `erc_hardware` - Sterowniki sprzętowe (CAN Open FD, Kamery, LIDAR).
- `erc_control` - Algorytmy sterowania (Manipulator, Napęd).
- `erc_autonomy` - Nawigacja (Nav2), wizja komputerowa i logika misji.
- `erc_simulation` - Środowisko symulacyjne Gazebo.

---

## Protokół Współpracy (Git Workflow)

Aby utrzymać stabilność kodu, stosujemy rygorystyczne zasady:

1.  **Brak bezpośredniego zapisu do `main`**: Gałąź główna jest zablokowana.
2.  **Feature Branches**: Każda zmiana powstaje na nowej gałęzi (np. `feature/nowy-sterownik`, `fix/blad-can`).
3.  **Pull Requests**: Scalenie kodu wymaga akceptacji (Code Review) innego członka zespołu.


Szczegółowa instrukcja tworzenia kodu znajduje się w dokumentacji na teams: 
```c
System obliczeniowy_sterowania -> Files -> Przewodnik Wdrożeniowy
```

---

## Stack Technologiczny

| **Komponent**                    | **Technologia**                      |
| -------------------------------- | ------------------------------------ |
| **System Operacyjny (Kontener)** | Ubuntu 22.04 LTS (Jammy Jellyfish)   |
| **Middleware**                   | ROS 2 Humble Hawksbill               |
| **Hardware (Rover)**             | NVIDIA Jetson Xavier AGX (L4T R35.x) |
| **Komunikacja**                  | CAN Open FD, Ethernet (DDS)          |
| **Języki**                       | Python 3.10                          |

---

© 2025 FusionTech ZUT.
