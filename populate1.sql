PRAGMA foreign_keys=ON;

INSERT INTO Person VALUES (12345678,'António Manuel da Silva', '1967-12-25', 123456789, 'Rua do Numeiro 42 R/C DTO', 4410823);
INSERT INTO Customer VALUES (12345678);
INSERT INTO VIPSubscription VALUES (78964327, 'Diamond', 0.99, TRUE, '1970-01-01', '2025-11-24', 12345678); 

INSERT INTO Person VALUES (23456789, 'Maria Joaquina Andrade', '1992-03-03', 555555555, 'Rua do Início do Fim 145', 3502123);
INSERT INTO CVInfo VALUES ('Sabe meter a língua no nariz', 42);
INSERT INTO Actor VALUES (23456789, 'Sabe meter a língua no nariz');


INSERT INTO Person VALUES (123467544,'Alexandre da Silva e Silva', '1999-12-31', 200200200, 'Rua do Ferrari 55 1Esq', 2323567);
INSERT INTO Employee VALUES (123467544, 'Consegue encher baldes de pipocas de olhos fechados');
INSERT INTO Cashier VALUES (123467544, 1, 5);
INSERT INTO Salary VALUES (78692342, 123467544, 870);
INSERT INTO WorkSchedule VALUES (76453542, 123467544, '09:00:00', '22:00:00', '2025-11-23');

INSERT INTO Person VALUES (34567890,'Amélio Lenha Bananeira', '2000-01-10', 674289651, 'Rua das Andorinhas 62 Picassinos', 2430320);
INSERT INTO Employee VALUES (34567890, 'Faz 33 reps in the rest day');
INSERT INTO Security VALUES (34567890, 1, 'Only Small Firearms', 'CIA Level');
INSERT INTO Salary VALUES (78692341, 34567890, 870);
INSERT INTO WorkSchedule VALUES (76453543, 34567890, '09:00:00', '22:00:00', '2025-11-23');

INSERT INTO Person VALUES (55645637, 'Sandra Madureira', '1967-12-01', 123456788, 'Rua Pedra Torta 89', 4400545);
INSERT INTO Employee VALUES (55645637, 'Limpa as sanitas com a língua com 99.99% de eficácia.');
INSERT INTO Cleaner VALUES (55645637, 'Casas de Banhos da entrada', 'Minigun, vassoura', 'Ajax dos cria');
INSERT INTO Salary VALUES (78692343, 55645637, 3345.01);
INSERT INTO WorkSchedule VALUES (76453544, 55645637, '09:00:00', '22:00:00', '2025-11-23');

INSERT INTO Exhibition VALUES (23983454, 'Top Gun: Maverick', 2022, 131, 'Aviões', 14);
INSERT INTO Movie VALUES (23983454, 4.1, 'Paramount Pictures');

INSERT INTO Exhibition VALUES (46743229, 'Hamilton', 2015, 165, 'Musical', 10);
INSERT INTO Play VALUES (46743229, 'Hamilton Broadway Company', 2, 'Hamilton production, featuring a rotating stage and period-inspired costumes.');

INSERT INTO Consume VALUES (12312871, 12.99);
INSERT INTO Food VALUES (12312871, 'small', 'nachos');

INSERT INTO Consume VALUES (12873654, 7.99);
INSERT INTO Drink VALUES (12873654, 'small', 'Peach Fuzetea');

INSERT INTO Consume VALUES (12873655, 19.99);
INSERT INTO Menu VALUES (12873655, 'kids');

INSERT INTO Room VALUES (0, 120, TRUE);

INSERT INTO Payment VALUES (23479834, 'card', 420.00);

INSERT INTO Bill VALUES (49786334, 40.00, '2025-11-23','12:21:47',123467544, 23479834, 12345678);

INSERT INTO ThemeInfo VALUES ('aniversary', 67);
INSERT INTO Reservation VALUES (56440891, 49786334, 'aniversary');

INSERT INTO Ticket VALUES (13458741, 49786334, 23983454, '14:45:00', 21, 'B', '2025-11-23', 7.99);

INSERT INTO ConsumeQ VALUES (12873655, 49786334, 99);

INSERT INTO ReservationSchedule VALUES (0, '14:30:00', '22:00:00', '2025-11-23', 56440891);

INSERT INTO RoomSchedule VALUES (0, 23983454, '18:00:00', '21:00:00', '2025-11-24');

INSERT INTO AgeRestriction VALUES (23983454, TRUE, 12345678);

INSERT INTO RoomSecurity VALUES (0, 34567890);
INSERT INTO RoomCleaner VALUES (0, 55645637);

INSERT INTO ActorPlay VALUES (23456789, 46743229);

INSERT INTO Person VALUES (45678901,'Sophia de Mello Breyner', '1919-11-06', 863094267, 'Rua da Antiguidade 67 DTO', 5437094);
INSERT INTO Person VALUES (78796541,'Pedro Vidraça', '1969-6-11', 789645002, 'Travessa do Peru 55', 6700987);
INSERT INTO Person VALUES (67756443, 'Tiago Cabelo de Lado', '2001-8-15',145256569, 'Praça da Massa 679 ESQ', 4458765);
INSERT INTO Person VALUES (56789012,'Tiago Sibano', '1998-09-23', 347859479, 'Rua da Matemática 88', 6767676);
INSERT INTO Person VALUES (17175689,'Rozala Costa', '1996-4-14', 245367456, 'Rua dos Dados 991', 4562453);
