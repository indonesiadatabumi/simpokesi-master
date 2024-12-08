-- Buat trigger untuk menangani operasi INSERT dan UPDATE di MySQL
DELIMITER $$

CREATE TRIGGER hiburans_after_insert
AFTER INSERT ON hiburans
FOR EACH ROW
BEGIN
    INSERT INTO hiburans_potensi_log (ref_id, target, tahun)
    VALUES (NEW.id, NEW.hiburan_potensi_pajak, YEAR(NEW.created_at));
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER hiburans_after_update
AFTER UPDATE ON hiburans
FOR EACH ROW
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM hiburans_potensi_log
        WHERE ref_id = NEW.id AND tahun = YEAR(NEW.created_at)
    ) THEN
        INSERT INTO hiburans_potensi_log (ref_id, target, tahun)
        VALUES (NEW.id, NEW.hiburan_potensi_pajak, YEAR(NEW.created_at));
    ELSE
        UPDATE hiburans_potensi_log
        SET target = NEW.hiburan_potensi_pajak
        WHERE ref_id = NEW.id AND tahun = YEAR(NEW.created_at);
    END IF;
END$$

DELIMITER ;

-- Buat trigger untuk menangani operasi INSERT dan UPDATE di MySQL
DELIMITER $$

CREATE TRIGGER airs_after_insert
AFTER INSERT ON airs
FOR EACH ROW
BEGIN
    INSERT INTO airs_potensi_log (ref_id, target, tahun)
    VALUES (NEW.id, NEW.potensi_pajak, YEAR(NEW.created_at));
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER airs_after_update
AFTER UPDATE ON airs
FOR EACH ROW
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM airs_potensi_log
        WHERE ref_id = NEW.id AND tahun = YEAR(NEW.created_at)
    ) THEN
        INSERT INTO airs_potensi_log (ref_id, target, tahun)
        VALUES (NEW.id, NEW.potensi_pajak, YEAR(NEW.created_at));
    ELSE
        UPDATE airs_potensi_log
        SET target = NEW.potensi_pajak
        WHERE ref_id = NEW.id AND tahun = YEAR(NEW.created_at);
    END IF;
END$$

DELIMITER ;


-- Buat trigger untuk menangani operasi INSERT dan UPDATE di MySQL
DELIMITER $$

CREATE TRIGGER hotels_after_insert
AFTER INSERT ON hotels
FOR EACH ROW
BEGIN
    INSERT INTO hotels_potensi_log (ref_id, target, tahun)
    VALUES (NEW.id, NEW.hotel_potensi_pajak, YEAR(NEW.created_at));
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER hotels_after_update
AFTER UPDATE ON hotels
FOR EACH ROW
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM hotels_potensi_log
        WHERE ref_id = NEW.id AND tahun = YEAR(NEW.created_at)
    ) THEN
        INSERT INTO hotels_potensi_log (ref_id, target, tahun)
        VALUES (NEW.id, NEW.hotel_potensi_pajak, YEAR(NEW.created_at));
    ELSE
        UPDATE hotels_potensi_log
        SET target = NEW.hotel_potensi_pajak
        WHERE ref_id = NEW.id AND tahun = YEAR(NEW.created_at);
    END IF;
END$$

DELIMITER ;


-- Buat trigger untuk menangani operasi INSERT dan UPDATE di MySQL
DELIMITER $$

CREATE TRIGGER parkirs_after_insert
AFTER INSERT ON parkirs
FOR EACH ROW
BEGIN
    INSERT INTO parkirs_potensi_log (ref_id, target, tahun)
    VALUES (NEW.id, NEW.parkir_potensi_pajak, YEAR(NEW.created_at));
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER parkirs_after_update
AFTER UPDATE ON parkirs
FOR EACH ROW
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM parkirs_potensi_log
        WHERE ref_id = NEW.id AND tahun = YEAR(NEW.created_at)
    ) THEN
        INSERT INTO parkirs_potensi_log (ref_id, target, tahun)
        VALUES (NEW.id, NEW.parkir_potensi_pajak, YEAR(NEW.created_at));
    ELSE
        UPDATE parkirs_potensi_log
        SET target = NEW.parkir_potensi_pajak
        WHERE ref_id = NEW.id AND tahun = YEAR(NEW.created_at);
    END IF;
END$$

DELIMITER ;


-- Buat trigger untuk menangani operasi INSERT dan UPDATE di MySQL
DELIMITER $$

CREATE TRIGGER penerangans_after_insert
AFTER INSERT ON penerangans
FOR EACH ROW
BEGIN
    INSERT INTO penerangans_potensi_log (ref_id, target, tahun)
    VALUES (NEW.id, NEW.potensi_pajak, YEAR(NEW.created_at));
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER penerangans_after_update
AFTER UPDATE ON penerangans
FOR EACH ROW
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM penerangans_potensi_log
        WHERE ref_id = NEW.id AND tahun = YEAR(NEW.created_at)
    ) THEN
        INSERT INTO penerangans_potensi_log (ref_id, target, tahun)
        VALUES (NEW.id, NEW.potensi_pajak, YEAR(NEW.created_at));
    ELSE
        UPDATE penerangans_potensi_log
        SET target = NEW.potensi_pajak
        WHERE ref_id = NEW.id AND tahun = YEAR(NEW.created_at);
    END IF;
END$$

DELIMITER ;


-- Buat trigger untuk menangani operasi INSERT dan UPDATE di MySQL
DELIMITER $$

CREATE TRIGGER restorans_after_insert
AFTER INSERT ON restorans
FOR EACH ROW
BEGIN
    INSERT INTO restorans_potensi_log (ref_id, target, tahun)
    VALUES (NEW.id, NEW.restoran_potensi_pajak, YEAR(NEW.created_at));
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER restorans_after_update
AFTER UPDATE ON restorans
FOR EACH ROW
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM restorans_potensi_log
        WHERE ref_id = NEW.id AND tahun = YEAR(NEW.created_at)
    ) THEN
        INSERT INTO restorans_potensi_log (ref_id, target, tahun)
        VALUES (NEW.id, NEW.restoran_potensi_pajak, YEAR(NEW.created_at));
    ELSE
        UPDATE restorans_potensi_log
        SET target = NEW.restoran_potensi_pajak
        WHERE ref_id = NEW.id AND tahun = YEAR(NEW.created_at);
    END IF;
END$$

DELIMITER ;


-- Buat trigger untuk menangani operasi INSERT dan UPDATE di MySQL
DELIMITER $$

CREATE TRIGGER reklames_after_insert
AFTER INSERT ON reklames
FOR EACH ROW
BEGIN
    INSERT INTO reklames_potensi_log (ref_id, target, tahun)
    VALUES (NEW.id, NEW.potensi_pajak, YEAR(NEW.created_at));
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER reklames_after_update
AFTER UPDATE ON reklames
FOR EACH ROW
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM reklames_potensi_log
        WHERE ref_id = NEW.id AND tahun = YEAR(NEW.created_at)
    ) THEN
        INSERT INTO reklames_potensi_log (ref_id, target, tahun)
        VALUES (NEW.id, NEW.potensi_pajak, YEAR(NEW.created_at));
    ELSE
        UPDATE reklames_potensi_log
        SET target = NEW.potensi_pajak
        WHERE ref_id = NEW.id AND tahun = YEAR(NEW.created_at);
    END IF;
END$$

DELIMITER ;
