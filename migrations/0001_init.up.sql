CREATE TABLE IF NOT EXISTS colors(
  color_id INT NOT NULL,
  name VARCHAR(45) NOT NULL,
  cost_per_ml DECIMAL(10,5) NOT NULL,
  actual_color VARCHAR(45) NOT NULL,
  description VARCHAR(100) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT NOW(),
  updated_at DATETIME NOT NULL DEFAULT NOW(),
  deleted_at DATETIME,
  PRIMARY KEY (color_id),
  UNIQUE INDEX color_id_UNIQUE (color_id ASC) VISIBLE,
  UNIQUE INDEX color_name_UNIQUE (name ASC, actual_color ASC) VISIBLE
);

CREATE TABLE IF NOT EXISTS drivetrains(
  drivetrain_id INT NOT NULL,
  type VARCHAR(45) NOT NULL,
  transmision VARCHAR(45) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT NOW(),
  updated_at DATETIME NOT NULL DEFAULT NOW(),
  deleted_at DATETIME,
  PRIMARY KEY (drivetrain_id),
  UNIQUE INDEX drivetrain_id_UNIQUE (drivetrain_id ASC) VISIBLE,
  UNIQUE INDEX type_transmition_UNIQUE (type ASC, transmision ASC) VISIBLE
);

CREATE TABLE IF NOT EXISTS engines(
  engine_id INT NOT NULL,
  name VARCHAR(45) NOT NULL,
  horsepower INT NOT NULL,
  fuel_type VARCHAR(45) NOT NULL,
  type VARCHAR(45) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT NOW(),
  updated_at DATETIME NOT NULL DEFAULT NOW(),
  deleted_at DATETIME,  
  PRIMARY KEY (engine_id),
  UNIQUE INDEX engine_id_UNIQUE (engine_id ASC) VISIBLE,
  UNIQUE INDEX name_UNIQUE (name ASC) VISIBLE
);

CREATE TABLE IF NOT EXISTS features(
  feature_id INT NOT NULL,
  name VARCHAR(45) NOT NULL,
  category VARCHAR(45) NOT NULL,
  description VARCHAR(100) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT NOW(),
  updated_at DATETIME NOT NULL DEFAULT NOW(),
  deleted_at DATETIME,  
  PRIMARY KEY (feature_id),
  UNIQUE INDEX feature_id_UNIQUE (feature_id ASC) VISIBLE
);

CREATE TABLE IF NOT EXISTS interiors(
  interior_id INT NOT NULL,
  color VARCHAR(45) NOT NULL,
  type VARCHAR(45) NOT NULL,
  number_seats INT NOT NULL,
  created_at DATETIME NOT NULL DEFAULT NOW(),
  updated_at DATETIME NOT NULL DEFAULT NOW(),
  deleted_at DATETIME,
  PRIMARY KEY (interior_id)
);

CREATE TABLE IF NOT EXISTS manufacturer(
  manufacturer_id INT NOT NULL,
  name VARCHAR(45) NOT NULL,
  country VARCHAR(45) NOT NULL,
  description VARCHAR(100) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT NOW(),
  updated_at DATETIME NOT NULL DEFAULT NOW(),
  deleted_at DATETIME,
  PRIMARY KEY (manufacturer_id),
  UNIQUE INDEX manufacturer_id_UNIQUE (manufacturer_id ASC) VISIBLE,
  UNIQUE INDEX name_UNIQUE (name ASC) VISIBLE 
);

CREATE TABLE IF NOT EXISTS packages(
  package_id INT NOT NULL,
  name VARCHAR(45) NOT NULL,
  description VARCHAR(100) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT NOW(),
  updated_at DATETIME NOT NULL DEFAULT NOW(),
  deleted_at DATETIME,
  PRIMARY KEY (package_id)
);

CREATE TABLE IF NOT EXISTS vehicle_classs(
  vehicle_class_id INT NOT NULL,
  name VARCHAR(45) NOT NULL,
  doors INT NOT NULL,
  description VARCHAR(100) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT NOW(),
  updated_at DATETIME NOT NULL DEFAULT NOW(),
  deleted_at DATETIME,
  PRIMARY KEY (vehicle_class_id),
  UNIQUE INDEX vehicle_class_id_UNIQUE (vehicle_class_id ASC) VISIBLE
);

-- Second Set of DBs
CREATE TABLE IF NOT EXISTS trims(
  trim_id INT NOT NULL,
  engine_id INT NOT NULL,
  drivetrain_id INT NOT NULL,
  interior_id INT NOT NULL,
  name VARCHAR(45) NOT NULL,
  description VARCHAR(100) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT NOW(),
  updated_at DATETIME NOT NULL DEFAULT NOW(),
  deleted_at DATETIME,
  PRIMARY KEY (trim_id, engine_id, drivetrain_id, interior_id),
  INDEX fk_trim_engines1_idx (engine_id ASC) VISIBLE,
  INDEX fk_trim_drivetrains1_idx (drivetrain_id ASC) VISIBLE,
  INDEX fk_trims_interiors1_idx (interior_id ASC) VISIBLE,
  CONSTRAINT fk_trim_engines1
    FOREIGN KEY (engine_id)
    REFERENCES engines (engine_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_trim_drivetrains1
    FOREIGN KEY (drivetrain_id)
    REFERENCES drivetrains (drivetrain_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_trims_interiors1
    FOREIGN KEY (interior_id)
    REFERENCES interiors (interior_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- Third Set of DBs
CREATE TABLE IF NOT EXISTS models(
  model_id INT NOT NULL,
  vehicle_class_id INT NOT NULL,
  trim_id INT NOT NULL,
  engine_id INT NOT NULL,
  drivetrain_id INT NOT NULL,
  interior_id INT NOT NULL,
  name VARCHAR(45) NOT NULL,
  safty_rating VARCHAR(45) NOT NULL,
  description VARCHAR(100) NOT NULL,
   created_at DATETIME NOT NULL DEFAULT NOW(),
   updated_at DATETIME NOT NULL DEFAULT NOW(),
   deleted_at DATETIME,
  PRIMARY KEY (model_id, vehicle_class_id, trim_id, engine_id, drivetrain_id, interior_id),
  INDEX fk_model_vehicle_classs1_idx (vehicle_class_id ASC) VISIBLE,
  INDEX fk_models_trims1_idx (trim_id ASC, engine_id ASC, drivetrain_id ASC, interior_id ASC) VISIBLE,
  CONSTRAINT fk_model_vehicle_classs1
    FOREIGN KEY (vehicle_class_id)
    REFERENCES vehicle_classs (vehicle_class_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_models_trims1
    FOREIGN KEY (trim_id , engine_id , drivetrain_id , interior_id)
    REFERENCES trims (trim_id , engine_id , drivetrain_id , interior_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- Fourth Set of DBs
CREATE TABLE IF NOT EXISTS features_list(
  feature_id INT NOT NULL,
  trim_id INT NULL DEFAULT NULL,
  model_id INT NULL DEFAULT NULL,
  package_id INT NULL DEFAULT NULL,
  created_at DATETIME NOT NULL DEFAULT NOW(),
  updated_at DATETIME NOT NULL DEFAULT NOW(),
  deleted_at DATETIME,  
  PRIMARY KEY (feature_id),
  INDEX fk_model_has_features_features1_idx (feature_id ASC) VISIBLE,
  INDEX fk_features_list_trim1_idx (trim_id ASC) VISIBLE,
  INDEX fk_features_list_model1_idx (model_id ASC) VISIBLE,
  INDEX fk_features_list_packages1_idx (package_id ASC) VISIBLE,
  CONSTRAINT fk_model_has_features_features1
    FOREIGN KEY (feature_id)
    REFERENCES features (feature_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_features_list_trim1
    FOREIGN KEY (trim_id)
    REFERENCES trims (trim_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_features_list_model1
    FOREIGN KEY (model_id)
    REFERENCES models (model_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_features_list_packages1
    FOREIGN KEY (package_id)
    REFERENCES packages (package_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS packages_list(
  package_id INT NOT NULL,
  trim_id INT NOT NULL,
  created_at DATETIME NOT NULL DEFAULT NOW(),
  updated_at DATETIME NOT NULL DEFAULT NOW(),
  deleted_at DATETIME,
  PRIMARY KEY (package_id, trim_id),
  INDEX fk_packages_has_trims_trims1_idx (trim_id ASC) VISIBLE,
  INDEX fk_packages_has_trims_packages1_idx (package_id ASC) VISIBLE,
  CONSTRAINT fk_packages_has_trims_packages1
    FOREIGN KEY (package_id)
    REFERENCES packages (package_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_packages_has_trims_trims1
    FOREIGN KEY (trim_id)
    REFERENCES trims (trim_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- Fifth
CREATE TABLE IF NOT EXISTS cars(
  vin_number VARCHAR(17) NOT NULL,
  manufacturer_id INT NOT NULL,
  color_id INT NOT NULL,
  model_id INT NOT NULL,
  vehicle_class_id INT NOT NULL,
  trim_id INT NOT NULL,
  engine_id INT NOT NULL,
  drivetrain_id INT NOT NULL,
  interior_id INT NOT NULL,
  year INT NOT NULL,
  mileage INT NOT NULL,
  description VARCHAR(100) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT NOW(),
  updated_at DATETIME NOT NULL DEFAULT NOW(),
  deleted_at DATETIME,
  PRIMARY KEY (vin_number, manufacturer_id, color_id, model_id, vehicle_class_id, trim_id, engine_id, drivetrain_id, interior_id),
  UNIQUE INDEX vin_number_UNIQUE (vin_number ASC) VISIBLE,
  INDEX fk_cars_manufacturer1_idx (manufacturer_id ASC) VISIBLE,
  INDEX fk_cars_colors1_idx (color_id ASC) VISIBLE,
  INDEX fk_cars_models1_idx (model_id ASC, vehicle_class_id ASC, trim_id ASC, engine_id ASC, drivetrain_id ASC, interior_id ASC) VISIBLE,
  CONSTRAINT fk_cars_manufacturer1
    FOREIGN KEY (manufacturer_id)
    REFERENCES manufacturer (manufacturer_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_cars_colors1
    FOREIGN KEY (color_id)
    REFERENCES colors (color_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_cars_models1
    FOREIGN KEY (model_id , vehicle_class_id , trim_id , engine_id , drivetrain_id , interior_id)
    REFERENCES models (model_id , vehicle_class_id , trim_id , engine_id , drivetrain_id , interior_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);