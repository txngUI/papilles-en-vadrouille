-- ============================================================
--  PAPILLES — V2__seed_dev_data.sql
--  Jeux de données de développement UNIQUEMENT
--  Activé via : spring.flyway.locations=classpath:db/migration,classpath:db/seed
--  NE S'EXÉCUTE JAMAIS en production
-- ============================================================

-- ============================================================
--  CATEGORIES
-- ============================================================
INSERT INTO categories (category_name) VALUES
    ('Italien'),
    ('Français'),
    ('Japonais'),
    ('Burger'),
    ('Mexicain'),
    ('Indien'),
    ('Libanais'),
    ('Végétarien'),
    ('Fruits de mer'),
    ('Coréen');

-- ============================================================
--  USERS
--  Mot de passe pour tous : Password123!
--  Hash bcrypt cost=12 généré offline
-- ============================================================
INSERT INTO users (email, password_hash, name, surname, phone, role, created_at) VALUES
    (
        'admin@papilles.fr',
        '$2a$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',
        'Admin',
        'Papilles',
        '0600000001',
        'ADMIN',
        NOW() - INTERVAL '90 days'
    ),
    (
        'valentine@papilles.fr',
        '$2a$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',
        'Valentine',
        'Dupont',
        '0600000002',
        'USER',
        NOW() - INTERVAL '60 days'
    ),
    (
        'marc@papilles.fr',
        '$2a$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',
        'Marc',
        'Bernard',
        '0600000003',
        'USER',
        NOW() - INTERVAL '30 days'
    );

-- ============================================================
--  RESTAURANTS — mix de villes françaises
-- ============================================================
INSERT INTO restaurants (
    name, description, website, phone,
    address, code_postal, city, country,
    latitude, longitude,
    category, price_min, price_max,
    is_best, created_by, created_at
) VALUES

-- ── Paris ──────────────────────────────────────────────────
(
    'In Teglia',
    'Pizza à la coupe, au levain, produits frais et recettes italiennes authentiques.',
    'https://integlia.fr', '01 42 00 11 22',
    '15 Rue de la Liberté', '75011', 'Paris', 'France',
    48.8566, 2.3522,
    1, 15, 30, TRUE, 2, NOW() - INTERVAL '55 days'
),
(
    'Le Comptoir du Relais',
    'Bistrot parisien emblématique, cuisine française de saison par Yves Camdeborde.',
    'https://hotel-paris-relais-saint-germain.com', '01 44 27 07 97',
    '9 Carrefour de l''Odéon', '75006', 'Paris', 'France',
    48.8530, 2.3374,
    2, 20, 45, FALSE, 2, NOW() - INTERVAL '50 days'
),
(
    'Kodawari Ramen',
    'Ramen authentiques dans un décor immersif évoquant les ruelles de Tokyo.',
    'https://kodawari-ramen.com', '01 40 51 00 00',
    '29 Rue Mazarine', '75006', 'Paris', 'France',
    48.8543, 2.3381,
    3, 15, 25, FALSE, 2, NOW() - INTERVAL '45 days'
),
(
    'Big Fernand',
    'Le hamburgé à la française — steak haché artisanal, pain brioché, sauces maison.',
    'https://bigfernand.com', '01 48 74 55 60',
    '55 Rue du Faubourg Poissonnière', '75009', 'Paris', 'France',
    48.8756, 2.3481,
    4, 12, 22, FALSE, 3, NOW() - INTERVAL '40 days'
),

-- ── Lyon ───────────────────────────────────────────────────
(
    'Le Bistrot des Halles',
    'Cuisine française traditionnelle revisitée avec des produits locaux du marché.',
    NULL, '04 72 00 22 33',
    '1 Place des Halles', '69001', 'Lyon', 'France',
    45.7676, 4.8344,
    2, 15, 30, FALSE, 2, NOW() - INTERVAL '35 days'
),
(
    'Sushi Yoshida',
    'Omakase et sushis de saison, poissons sourcés quotidiennement à Rungis.',
    NULL, '04 78 00 44 55',
    '12 Rue Mercière', '69002', 'Lyon', 'France',
    45.7640, 4.8330,
    3, 35, 80, FALSE, 3, NOW() - INTERVAL '30 days'
),
(
    'Neon',
    'Burgers gourmets et cocktails dans une ambiance rétro néon. Ouvert tard.',
    'https://neon-lyon.fr', '04 78 00 66 77',
    '3 Rue de la Martinière', '69001', 'Lyon', 'France',
    45.7665, 4.8313,
    4, 14, 25, FALSE, 3, NOW() - INTERVAL '25 days'
),

-- ── Bordeaux ───────────────────────────────────────────────
(
    'La Brasserie Bordelaise',
    'Fruits de mer, huîtres du bassin d''Arcachon et vins de Bordeaux en terrasse.',
    NULL, '05 56 00 88 99',
    '11 Place du Parlement', '33000', 'Bordeaux', 'France',
    44.8378, -0.5792,
    9, 25, 60, FALSE, 2, NOW() - INTERVAL '20 days'
),
(
    'Green Bowl',
    'Cuisine végétarienne créative, bowls colorés et jus pressés à froid.',
    NULL, '05 56 00 11 00',
    '8 Rue des Remparts', '33000', 'Bordeaux', 'France',
    44.8404, -0.5736,
    8, 12, 20, FALSE, 3, NOW() - INTERVAL '15 days'
),

-- ── Lille ──────────────────────────────────────────────────
(
    'Le Bloempot',
    'Gastronomie du terroir nordiste réinterprétée avec audace. Réservation conseillée.',
    'https://lebloempot.fr', '03 20 00 22 11',
    '22 Rue des Bouchers', '59000', 'Lille', 'France',
    50.6292, 3.0573,
    2, 40, 90, FALSE, 2, NOW() - INTERVAL '10 days'
);

-- ============================================================
--  OPINIONS
-- ============================================================
INSERT INTO opinions (user_id, restaurant_id, rate, content, date_created) VALUES
    (2, 1, 5, 'Absolument incroyable. La pizza margherita est la meilleure que j''aie mangée hors d''Italie. On y retourne chaque mois !', NOW() - INTERVAL '50 days'),
    (3, 1, 4, 'Très bon rapport qualité-prix. Légèrement bruyant le week-end mais la pizza vaut le déplacement.', NOW() - INTERVAL '40 days'),
    (2, 2, 5, 'Une institution. Le tartare de boeuf est parfait, le service aux petits soins. Indétrônable.', NOW() - INTERVAL '45 days'),
    (3, 2, 4, 'Cuisine classique et généreuse. Difficile d''avoir une table sans réserver longtemps à l''avance.', NOW() - INTERVAL '35 days'),
    (2, 3, 5, 'Le ramen tonkotsu est d''une richesse incroyable. Le décor plonge vraiment dans l''ambiance japonaise.', NOW() - INTERVAL '42 days'),
    (3, 4, 4, 'Bon burger, pain brioché moelleux. Un peu cher pour ce que c''est mais la qualité est là.', NOW() - INTERVAL '38 days'),
    (2, 5, 5, 'Enfin un vrai bistrot lyonnais sans chichi. La quenelle sauce Nantua est un régal.', NOW() - INTERVAL '30 days'),
    (3, 5, 4, 'Bon accueil, produits frais. Le menu du midi est excellent rapport qualité-prix.', NOW() - INTERVAL '22 days'),
    (2, 8, 4, 'Plateau de fruits de mer impeccable, huîtres ultra-fraîches. La terrasse sur la place est magnifique.', NOW() - INTERVAL '18 days'),
    (3, 10, 5, 'Une révélation. La cuisine du Nord revisitée avec des produits d''exception. Menu dégustation à couper le souffle.', NOW() - INTERVAL '8 days');

-- ============================================================
--  OPINION LIKES
-- ============================================================
INSERT INTO opinion_like (user_id, opinion_id) VALUES
    (3, 1),
    (1, 1),
    (2, 4),
    (1, 5),
    (3, 7),
    (1, 10);

-- ============================================================
--  FAVOURITES
-- ============================================================
INSERT INTO favourites (user_id, restaurant_id, created_at) VALUES
    (2, 1, NOW() - INTERVAL '48 days'),
    (2, 3, NOW() - INTERVAL '40 days'),
    (2, 5, NOW() - INTERVAL '28 days'),
    (2, 10, NOW() - INTERVAL '7 days'),
    (3, 1, NOW() - INTERVAL '38 days'),
    (3, 4, NOW() - INTERVAL '35 days'),
    (3, 7, NOW() - INTERVAL '20 days');

-- ============================================================
--  NOTIFICATIONS
-- ============================================================
INSERT INTO notifications (user_id, notified_id, type, is_read, created_at) VALUES
    (3, 2, 'OPINION_LIKE',      FALSE, NOW() - INTERVAL '38 days'),
    (1, 2, 'OPINION_LIKE',      FALSE, NOW() - INTERVAL '35 days'),
    (3, 2, 'NEW_OPINION',       FALSE, NOW() - INTERVAL '22 days'),
    (2, 3, 'OPINION_LIKE',      TRUE,  NOW() - INTERVAL '20 days'),
    (1, 2, 'NEW_OPINION',       FALSE, NOW() - INTERVAL '8 days');

-- ============================================================
--  NOTIFICATIONS PREFERENCES
-- ============================================================
INSERT INTO notifications_preferences (user_id, type, enabled) VALUES
    (2, 'OPINION_LIKE', TRUE),
    (2, 'NEW_OPINION',  TRUE),
    (2, 'NEW_REPORT',   TRUE),
    (3, 'OPINION_LIKE', TRUE),
    (3, 'NEW_OPINION',  FALSE);

-- ============================================================
--  INSCRIPTIONS
-- ============================================================
INSERT INTO inscriptions (user_id, date_asked, reason, status) VALUES
    (2, NOW() - INTERVAL '61 days', 'Passionnée de gastronomie, je voyage beaucoup et veux partager mes découvertes culinaires.', 'APPROVED'),
    (3, NOW() - INTERVAL '31 days', 'Amateur de restaurants, je veux contribuer à la communauté Papilles.', 'APPROVED');
