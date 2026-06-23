# Papilles en vadrouilles

Application de découverte et d'évaluation de restaurants.

## Stack technique

| Couche | Technologie |
|--------|-------------|
| Backend | Spring Boot 3.3 · Java 21 |
| Frontend | Angular 17+ |
| Base de données | PostgreSQL 16 |
| Migrations | Flyway |
| Reverse proxy (prod) | Nginx |

## Prérequis

- Java 21+
- Maven 3.9+
- Node.js 20+ et npm
- Docker & Docker Compose

## Démarrage rapide

### 1. Cloner le projet

```bash
git clone https://github.com/ton-user/papilles.git
cd papilles
```

### 2. Variables d'environnement

Copier le fichier d'exemple et renseigner les valeurs :

```bash
cp .env.example .env
```

> Le fichier `.env` n'est jamais commité. Voir `.env.example` pour les variables requises.

### 3. Lancer la base de données

```bash
docker compose up -d
```

PostgreSQL est disponible sur `localhost:5432`.  
Adminer (interface web DB) : `docker compose --profile tools up -d` → `http://localhost:8081`

### 4. Lancer le backend

```bash
cd papilles-api
./mvnw spring-boot:run
```

L'API est disponible sur `http://localhost:8080`.  
Documentation Swagger : `http://localhost:8080/swagger-ui.html` *(à configurer)*

### 5. Lancer le frontend

```bash
cd papilles-web
npm install
ng serve
```

L'application est disponible sur `http://localhost:4200`.

## Structure du projet

```
papilles/
├── papilles-api/        # API REST Spring Boot
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/papilles/api/
│   │   │   └── resources/
│   │   │       ├── application.yml
│   │   │       └── db/migration/     # Scripts Flyway
│   │   └── test/
│   └── pom.xml
├── papilles-web/        # Application Angular
│   ├── src/
│   │   └── app/
│   │       ├── core/
│   │       ├── features/
│   │       └── shared/
│   └── angular.json
├── docker-compose.yml   # PostgreSQL en local
├── .env.example         # Template des variables d'environnement
└── README.md
```

## Variables d'environnement

| Variable | Description | Défaut dev |
|----------|-------------|------------|
| `POSTGRES_DB` | Nom de la base | `papilles` |
| `POSTGRES_USER` | Utilisateur DB | `papilles` |
| `POSTGRES_PASSWORD` | Mot de passe DB | *(à définir)* |
| `JWT_SECRET` | Clé secrète JWT (min 256 bits) | *(à définir)* |
| `JWT_EXPIRATION` | Durée de vie du token (ms) | `86400000` |

## Commandes utiles

```bash
# Démarrer uniquement la DB
docker compose up -d

# Démarrer la DB + Adminer
docker compose --profile tools up -d

# Stopper tout
docker compose down

# Supprimer les données (reset DB)
docker compose down -v

# Voir les logs de la DB
docker compose logs -f postgres

# Générer un composant Angular
cd papilles-web && ng generate component features/restaurants/components/restaurant-card

# Générer un service Angular
cd papilles-web && ng generate service core/services/restaurant
```

## Conventions

- **Branches** : `main` (prod) · `develop` (intégration) · `feature/nom-feature`
- **Commits** : format Conventional Commits — `feat:`, `fix:`, `chore:`, `docs:`
- **Java** : PascalCase classes · camelCase variables · snake_case DB
- **Angular** : kebab-case composants · camelCase variables · PascalCase classes

## Déploiement (VPS)

> Documentation à venir dans `/docs/deploiement.md`

Schéma cible :
```
Internet (443)
    └── Nginx
         ├── /        → dist/papilles-web/  (statique)
         └── /api/**  → Spring Boot :8080   (reverse proxy)
```
