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

CREATE INDEX medical_history_id_index
 ON medical_histories (patient_id);

CREATE TABLE treatments (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    type VARCHAR(20) NOT NULL,
    name VARCHAR(20) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE medical_treatment_history(
  treatement_id INTEGER REFERENCES treatments(id),
  medical_history_id INTEGER REFERENCES medical_histories(id),
  PRIMARY KEY (treatement_id, medical_history_id) 
);

CREATE INDEX medical_treatment_clustered_index
ON medical_treatment_history USING btree (treatement_id, medical_history_id);

CREATE TABLE invoices (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    total_amount DECIMAL NOT NULL,
    generated_at TIMESTAMP NOT NULL,
    payed_at TIMESTAMP,
    medical_histories INTEGER,
    PRIMARY KEY (id),
    CONSTRAINT "fk_medical_histories.id"
    FOREIGN KEY (medical_histories)
     REFERENCES medical_histories(id)
        ON DELETE CASCADE
);

CREATE INDEX invoices_id_index
 ON invoices (medical_histories);

CREATE TABLE invoice_items(
    id INTEGER GENERATED ALWAYS AS IDENTITY,
   unit_price DECIMAL NOT NULL,
   quantity INT NOT NULL,
   total_price DECIMAL NOT NULL,
   invoice_id INTEGER,
   treatment_id INTEGER ,
    PRIMARY KEY (id),
    CONSTRAINT "fk_invoice.id"
    FOREIGN KEY (invoice_id)
     REFERENCES invoices(id)
        ON DELETE CASCADE
);

CREATE INDEX invoice_items_id_index
 ON invoice_items (invoice_id);