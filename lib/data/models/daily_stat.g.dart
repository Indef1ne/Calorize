// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_stat.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDailyStatCollection on Isar {
  IsarCollection<DailyStat> get dailyStats => this.collection();
}

const DailyStatSchema = CollectionSchema(
  name: r'DailyStat',
  id: -8394353298243927381,
  properties: {
    r'bmi': PropertySchema(
      id: 0,
      name: r'bmi',
      type: IsarType.double,
    ),
    r'date': PropertySchema(
      id: 1,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'goalMetWithinRange': PropertySchema(
      id: 2,
      name: r'goalMetWithinRange',
      type: IsarType.bool,
    ),
    r'rolloverFromPreviousDay': PropertySchema(
      id: 3,
      name: r'rolloverFromPreviousDay',
      type: IsarType.double,
    ),
    r'rolloverToNextDay': PropertySchema(
      id: 4,
      name: r'rolloverToNextDay',
      type: IsarType.double,
    ),
    r'totalCalories': PropertySchema(
      id: 5,
      name: r'totalCalories',
      type: IsarType.long,
    ),
    r'totalCarbs': PropertySchema(
      id: 6,
      name: r'totalCarbs',
      type: IsarType.double,
    ),
    r'totalFat': PropertySchema(
      id: 7,
      name: r'totalFat',
      type: IsarType.double,
    ),
    r'totalProtein': PropertySchema(
      id: 8,
      name: r'totalProtein',
      type: IsarType.double,
    ),
    r'weightEntry': PropertySchema(
      id: 9,
      name: r'weightEntry',
      type: IsarType.double,
    )
  },
  estimateSize: _dailyStatEstimateSize,
  serialize: _dailyStatSerialize,
  deserialize: _dailyStatDeserialize,
  deserializeProp: _dailyStatDeserializeProp,
  idName: r'id',
  indexes: {
    r'date': IndexSchema(
      id: -7552997827385218417,
      name: r'date',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'date',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _dailyStatGetId,
  getLinks: _dailyStatGetLinks,
  attach: _dailyStatAttach,
  version: '3.1.0+1',
);

int _dailyStatEstimateSize(
  DailyStat object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _dailyStatSerialize(
  DailyStat object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.bmi);
  writer.writeDateTime(offsets[1], object.date);
  writer.writeBool(offsets[2], object.goalMetWithinRange);
  writer.writeDouble(offsets[3], object.rolloverFromPreviousDay);
  writer.writeDouble(offsets[4], object.rolloverToNextDay);
  writer.writeLong(offsets[5], object.totalCalories);
  writer.writeDouble(offsets[6], object.totalCarbs);
  writer.writeDouble(offsets[7], object.totalFat);
  writer.writeDouble(offsets[8], object.totalProtein);
  writer.writeDouble(offsets[9], object.weightEntry);
}

DailyStat _dailyStatDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DailyStat();
  object.bmi = reader.readDoubleOrNull(offsets[0]);
  object.date = reader.readDateTime(offsets[1]);
  object.goalMetWithinRange = reader.readBool(offsets[2]);
  object.id = id;
  object.rolloverFromPreviousDay = reader.readDouble(offsets[3]);
  object.rolloverToNextDay = reader.readDouble(offsets[4]);
  object.totalCalories = reader.readLong(offsets[5]);
  object.totalCarbs = reader.readDouble(offsets[6]);
  object.totalFat = reader.readDouble(offsets[7]);
  object.totalProtein = reader.readDouble(offsets[8]);
  object.weightEntry = reader.readDoubleOrNull(offsets[9]);
  return object;
}

P _dailyStatDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    case 8:
      return (reader.readDouble(offset)) as P;
    case 9:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dailyStatGetId(DailyStat object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _dailyStatGetLinks(DailyStat object) {
  return [];
}

void _dailyStatAttach(IsarCollection<dynamic> col, Id id, DailyStat object) {
  object.id = id;
}

extension DailyStatQueryWhereSort
    on QueryBuilder<DailyStat, DailyStat, QWhere> {
  QueryBuilder<DailyStat, DailyStat, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterWhere> anyDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'date'),
      );
    });
  }
}

extension DailyStatQueryWhere
    on QueryBuilder<DailyStat, DailyStat, QWhereClause> {
  QueryBuilder<DailyStat, DailyStat, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterWhereClause> dateEqualTo(
      DateTime date) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'date',
        value: [date],
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterWhereClause> dateNotEqualTo(
      DateTime date) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [],
              upper: [date],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [date],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [date],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'date',
              lower: [],
              upper: [date],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterWhereClause> dateGreaterThan(
    DateTime date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [date],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterWhereClause> dateLessThan(
    DateTime date, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [],
        upper: [date],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterWhereClause> dateBetween(
    DateTime lowerDate,
    DateTime upperDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'date',
        lower: [lowerDate],
        includeLower: includeLower,
        upper: [upperDate],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DailyStatQueryFilter
    on QueryBuilder<DailyStat, DailyStat, QFilterCondition> {
  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition> bmiIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bmi',
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition> bmiIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bmi',
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition> bmiEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bmi',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition> bmiGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bmi',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition> bmiLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bmi',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition> bmiBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bmi',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition> dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition>
      goalMetWithinRangeEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'goalMetWithinRange',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition>
      rolloverFromPreviousDayEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rolloverFromPreviousDay',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition>
      rolloverFromPreviousDayGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rolloverFromPreviousDay',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition>
      rolloverFromPreviousDayLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rolloverFromPreviousDay',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition>
      rolloverFromPreviousDayBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rolloverFromPreviousDay',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition>
      rolloverToNextDayEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rolloverToNextDay',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition>
      rolloverToNextDayGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rolloverToNextDay',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition>
      rolloverToNextDayLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rolloverToNextDay',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition>
      rolloverToNextDayBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rolloverToNextDay',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition>
      totalCaloriesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalCalories',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition>
      totalCaloriesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalCalories',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition>
      totalCaloriesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalCalories',
        value: value,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition>
      totalCaloriesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalCalories',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition> totalCarbsEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalCarbs',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition>
      totalCarbsGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalCarbs',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition> totalCarbsLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalCarbs',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition> totalCarbsBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalCarbs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition> totalFatEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalFat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition> totalFatGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalFat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition> totalFatLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalFat',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition> totalFatBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalFat',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition> totalProteinEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalProtein',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition>
      totalProteinGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalProtein',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition>
      totalProteinLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalProtein',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition> totalProteinBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalProtein',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition>
      weightEntryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'weightEntry',
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition>
      weightEntryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'weightEntry',
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition> weightEntryEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weightEntry',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition>
      weightEntryGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weightEntry',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition> weightEntryLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weightEntry',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterFilterCondition> weightEntryBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weightEntry',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension DailyStatQueryObject
    on QueryBuilder<DailyStat, DailyStat, QFilterCondition> {}

extension DailyStatQueryLinks
    on QueryBuilder<DailyStat, DailyStat, QFilterCondition> {}

extension DailyStatQuerySortBy on QueryBuilder<DailyStat, DailyStat, QSortBy> {
  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> sortByBmi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bmi', Sort.asc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> sortByBmiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bmi', Sort.desc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> sortByGoalMetWithinRange() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalMetWithinRange', Sort.asc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy>
      sortByGoalMetWithinRangeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalMetWithinRange', Sort.desc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy>
      sortByRolloverFromPreviousDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rolloverFromPreviousDay', Sort.asc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy>
      sortByRolloverFromPreviousDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rolloverFromPreviousDay', Sort.desc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> sortByRolloverToNextDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rolloverToNextDay', Sort.asc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy>
      sortByRolloverToNextDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rolloverToNextDay', Sort.desc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> sortByTotalCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCalories', Sort.asc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> sortByTotalCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCalories', Sort.desc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> sortByTotalCarbs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCarbs', Sort.asc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> sortByTotalCarbsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCarbs', Sort.desc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> sortByTotalFat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFat', Sort.asc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> sortByTotalFatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFat', Sort.desc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> sortByTotalProtein() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalProtein', Sort.asc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> sortByTotalProteinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalProtein', Sort.desc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> sortByWeightEntry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightEntry', Sort.asc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> sortByWeightEntryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightEntry', Sort.desc);
    });
  }
}

extension DailyStatQuerySortThenBy
    on QueryBuilder<DailyStat, DailyStat, QSortThenBy> {
  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> thenByBmi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bmi', Sort.asc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> thenByBmiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bmi', Sort.desc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> thenByGoalMetWithinRange() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalMetWithinRange', Sort.asc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy>
      thenByGoalMetWithinRangeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalMetWithinRange', Sort.desc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy>
      thenByRolloverFromPreviousDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rolloverFromPreviousDay', Sort.asc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy>
      thenByRolloverFromPreviousDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rolloverFromPreviousDay', Sort.desc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> thenByRolloverToNextDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rolloverToNextDay', Sort.asc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy>
      thenByRolloverToNextDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rolloverToNextDay', Sort.desc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> thenByTotalCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCalories', Sort.asc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> thenByTotalCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCalories', Sort.desc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> thenByTotalCarbs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCarbs', Sort.asc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> thenByTotalCarbsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCarbs', Sort.desc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> thenByTotalFat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFat', Sort.asc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> thenByTotalFatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFat', Sort.desc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> thenByTotalProtein() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalProtein', Sort.asc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> thenByTotalProteinDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalProtein', Sort.desc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> thenByWeightEntry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightEntry', Sort.asc);
    });
  }

  QueryBuilder<DailyStat, DailyStat, QAfterSortBy> thenByWeightEntryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightEntry', Sort.desc);
    });
  }
}

extension DailyStatQueryWhereDistinct
    on QueryBuilder<DailyStat, DailyStat, QDistinct> {
  QueryBuilder<DailyStat, DailyStat, QDistinct> distinctByBmi() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bmi');
    });
  }

  QueryBuilder<DailyStat, DailyStat, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<DailyStat, DailyStat, QDistinct> distinctByGoalMetWithinRange() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'goalMetWithinRange');
    });
  }

  QueryBuilder<DailyStat, DailyStat, QDistinct>
      distinctByRolloverFromPreviousDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rolloverFromPreviousDay');
    });
  }

  QueryBuilder<DailyStat, DailyStat, QDistinct> distinctByRolloverToNextDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rolloverToNextDay');
    });
  }

  QueryBuilder<DailyStat, DailyStat, QDistinct> distinctByTotalCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalCalories');
    });
  }

  QueryBuilder<DailyStat, DailyStat, QDistinct> distinctByTotalCarbs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalCarbs');
    });
  }

  QueryBuilder<DailyStat, DailyStat, QDistinct> distinctByTotalFat() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalFat');
    });
  }

  QueryBuilder<DailyStat, DailyStat, QDistinct> distinctByTotalProtein() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalProtein');
    });
  }

  QueryBuilder<DailyStat, DailyStat, QDistinct> distinctByWeightEntry() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weightEntry');
    });
  }
}

extension DailyStatQueryProperty
    on QueryBuilder<DailyStat, DailyStat, QQueryProperty> {
  QueryBuilder<DailyStat, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DailyStat, double?, QQueryOperations> bmiProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bmi');
    });
  }

  QueryBuilder<DailyStat, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<DailyStat, bool, QQueryOperations> goalMetWithinRangeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'goalMetWithinRange');
    });
  }

  QueryBuilder<DailyStat, double, QQueryOperations>
      rolloverFromPreviousDayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rolloverFromPreviousDay');
    });
  }

  QueryBuilder<DailyStat, double, QQueryOperations>
      rolloverToNextDayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rolloverToNextDay');
    });
  }

  QueryBuilder<DailyStat, int, QQueryOperations> totalCaloriesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalCalories');
    });
  }

  QueryBuilder<DailyStat, double, QQueryOperations> totalCarbsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalCarbs');
    });
  }

  QueryBuilder<DailyStat, double, QQueryOperations> totalFatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalFat');
    });
  }

  QueryBuilder<DailyStat, double, QQueryOperations> totalProteinProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalProtein');
    });
  }

  QueryBuilder<DailyStat, double?, QQueryOperations> weightEntryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weightEntry');
    });
  }
}
