#!/bin/bash

echo "🚀 Préparation de la soumission F-Droid pour Liberchat v3.5.0"

# Vérifier que le fichier de métadonnées existe
if [ ! -f "metadata/com.liberchat.mobile.yml" ]; then
    echo "❌ Fichier de métadonnées manquant !"
    exit 1
fi

echo "✅ Fichier de métadonnées trouvé"

# Afficher les informations de soumission
echo ""
echo "📋 Informations de soumission :"
echo "   Nom: Liberchat"
echo "   ID: com.liberchat.mobile"
echo "   Version: 3.5.0"
echo "   Licence: MIT"
echo "   Dépôt: https://github.com/Liberchat/Liberchat-android"
echo "   Branche: Liberchat3.5"

echo ""
echo "📝 Étapes suivantes pour soumettre à F-Droid :"
echo ""
echo "1. Va sur : https://gitlab.com/fdroid/fdroiddata"
echo "2. Fork le dépôt"
echo "3. Clone ton fork :"
echo "   git clone https://gitlab.com/TON_USERNAME/fdroiddata.git"
echo ""
echo "4. Copie le fichier de métadonnées :"
echo "   cp metadata/com.liberchat.mobile.yml fdroiddata/metadata/"
echo ""
echo "5. Commit et push :"
echo "   cd fdroiddata"
echo "   git add metadata/com.liberchat.mobile.yml"
echo "   git commit -m 'Add Liberchat v3.5.0 - Modern chat application'"
echo "   git push origin main"
echo ""
echo "6. Crée une Merge Request sur GitLab"
echo ""
echo "🎉 Ton app sera alors reviewée par l'équipe F-Droid !"

# Vérifier la validité du fichier YAML
echo ""
echo "🔍 Vérification du fichier de métadonnées..."
if command -v yamllint &> /dev/null; then
    yamllint metadata/com.liberchat.mobile.yml
    echo "✅ Fichier YAML valide"
else
    echo "⚠️  yamllint non installé, impossible de vérifier la syntaxe"
fi

echo ""
echo "📁 Fichier de métadonnées prêt : metadata/com.liberchat.mobile.yml"
echo "📄 Documentation : fdroid-submission.md"