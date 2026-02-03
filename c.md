# C.MD
A file with useful commands

## GraphQL

### Fetching schema.graphql
```bash
# Using npx (Node.js required)
npx get-graphql-schema http://localhost:4000/ > lib/schema.graphql
```

### Generate Type-safe Classes
```bash
dart run build_runner build --delete-conflicting-outputs
```

## Branching
Remove deleted origin branches: 
```bash
git fetch -p
```

View branches with deleted origin: 
```bash
git branch -vv
```

Delete all branches with deleted origins
```bash
git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -d
```

## Testing

```bash 
flutter test --coverage --branch-coverage
genhtml coverage/lcov.info -o coverage/html --branch-coverage --ignore-errors inconsistent
```

## Deeplinking

### iOS
```bash
app://alfie.com/{app_route} (inside notes or clickable link)
```

### Android
```bash
adb shell am start -a android.intent.action.VIEW -d "app://alfie.com/{app_route}" (in terminal)
```

## Adding Icons
Here it is showned the process of getting a Icon Font in order to use the icons with the `Icon` flutter widget

- Download Icons with 2px border and 24x24 size
- Open [FlutterIcon](https://www.fluttericon.com/), drag all the Icons, select the Class name for the icons (e.g. `AppIcons`)
- Download Resultant Icon Font and add it to the projct under `assets/fonts/`
- Add the downloaded font to `pubspec.yaml`
- Add the .dart class to `/lib/core/themes/`
- Use it as you whould use `Icons` or `CupertinoIcons`.