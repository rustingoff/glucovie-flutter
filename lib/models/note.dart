import "dart:convert";
import "package:flutter/material.dart";
import 'package:sqflite/sqflite.dart';
part "note.g.dart";

const tagTable = Sqf(
  tableName: "tag",
  primaryKeyName: "id",
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  useSoftDeleting: true,
  fields: [
    SqfEntityField("tag", DbType.text, isNotNull: true),
  ],
);

const notesTable = SqfEntityTable(
  tableName: "note",
  primaryKeyName: "id",
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  useSoftDeleting: true,
  fields: [
    SqfEntityField("title", DbType.text, isNotNull: true),
    SqfEntityField("body", DbType.text),
    SqfEntityFieldRelationship(
      parentTable: tagTable,
      fieldName: "tag",
    ),
    SqfEntityField("updatedAt", DbType.datetime),
  ],
);

@SqfEntityBuilder(myDbModel)
const myDbModel = SqfEntityModel(
  modelName: "Notes",
  databaseName: "notes.db",
  databaseTables: [notesTable, tagTable],
  defaultColumns: [
    SqfEntityField(
      "createdAt",
      DbType.datetime,
      defaultValue: "DateTime.now()",
    ),
  ],
);
