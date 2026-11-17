# Taller 1 (02_bash)

Juliana González Sánchez

**1. ¿Qué función cumple `#!/bin/bash`?**
Es el shebang: indica qué intérprete usar cuando el archivo se ejecuta directamente.

**2. ¿Qué diferencia existe entre `bash saludo.sh` y `./saludo.sh`?**
`bash saludo.sh` llama al intérprete directamente y no necesita permiso de ejecución. `./saludo.sh` ejecuta el archivo como programa: necesita permiso `x` y usa el shebang.

**3. ¿Qué ocurre si el archivo no tiene permisos de ejecución?**
`./saludo.sh` falla con `Permission denied` (código de salida 126).

**4. ¿Qué información devuelve `$?` después de ejecutar un comando?**
Su código de salida: `0` si terminó bien, otro número si falló.
