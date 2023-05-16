CREATE DATABASE clinic;

CREATE TABLE patients (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(20) NOT NULL,
    date_of_birth Date NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE medical_histories (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    admitted_at TIMESTAMP NOT NULL,
    patient_id  INT,
    status VARCHAR(20) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT "fk_patient.id"
    FOREIGN KEY (patient_id)
     REFERENCES patients(id)
        ON DELETE CASCADE
);

CREATE TABLE treatments (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    type VARCHAR(20) NOT NULL,
    name VARCHAR(20) NOT NULL,
    PRIMARY KEY (id)
);
