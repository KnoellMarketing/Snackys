/*!
 * FileInput German Translations
 *
 * This file must be loaded after 'fileinput.js'. Patterns in braces '{}', or
 * any HTML markup tags in the messages must not be converted or translated.
 *
 * @see http://github.com/kartik-v/bootstrap-fileinput
 */
(function ($) {
    "use strict";

    $.fn.fileinputLocales['de'] = {
        fileSingle: 'Datei',
        filePlural: 'Dateien',
        browseLabel: 'Ausw�hlen &hellip;',
        removeLabel: 'L�schen',
        removeTitle: 'Ausgew�hlte l�schen',
        cancelLabel: 'Laden',
        cancelTitle: 'Hochladen abbrechen',
        uploadLabel: 'Hochladen',
        uploadTitle: 'Hochladen der ausgew�hlten Dateien',
        msgZoomTitle: 'Details anzeigen',
        msgZoomModalHeading: 'ausf�hrliche Vorschau',
        msgSizeTooLarge: 'Datei "{name}" (<b>{size} KB</b>) �berschreitet maximal zul�ssige Upload-Gr��e von <b>{maxSize} KB</b>.',
        msgFilesTooLess: 'Sie m�ssen mindestens <b>{n}</b> {files} zum Hochladen ausw�hlen.',
        msgFilesTooMany: 'Anzahl der Dateien f�r den Upload ausgew�hlt <b>({n})</b> �berschreitet maximal zul�ssige Grenze von <b>{m}</b> St�ck.',
        msgFileNotFound: 'Datei "{name}" wurde nicht gefunden!',
        msgFileSecured: 'Sicherheitseinstellungen verhindern das Lesen der Datei "{name}".',
        msgFileNotReadable: 'Die Datei "{name}" ist nicht lesbar.',
        msgFilePreviewAborted: 'Dateivorschau abgebrochen f�r "{name}".',
        msgFilePreviewError: 'Beim Lesen der Datei "{name}" ein Fehler aufgetreten.',
        msgInvalidFileType: 'Ung�ltiger Typ f�r Datei "{name}". Nur Dateien der Typen "{types}" werden unterst�tzt.',
        msgInvalidFileExtension: 'Ung�ltige Erweiterung f�r Datei "{name}". Nur Dateien mit der Endung "{extensions}" werden unterst�tzt.',
        msgUploadAborted: 'Der Datei-Upload wurde abgebrochen',
        msgValidationError: 'Fehler beim Hochladen',
        msgLoading: 'Lade Datei {index} von {files} hoch&hellip;',
        msgProgress: 'Datei {index} von {files} - {name} - zu {percent}% fertiggestellt.',
        msgSelected: '{n} {files} ausgew�hlt',
        msgFoldersNotAllowed: 'Drag & Drop funktioniert nur bei Dateien! {n} Ordner �bersprungen.',
        msgImageWidthSmall: 'Breite der Bilddatei "{name}" muss mindestens {size} px betragen.',
        msgImageHeightSmall: 'H�he der Bilddatei "{name}" muss mindestens {size} px betragen.',
        msgImageWidthLarge: 'Breite der Bilddatei "{name}" nicht �berschreiten {size} px.',
        msgImageHeightLarge: 'H�he der Bilddatei "{name}" nicht �berschreiten {size} px.',
        msgImageResizeError: 'Konnte nicht die Bildabmessungen zu �ndern.',
        msgImageResizeException: 'Fehler beim �ndern der Gr��e des Bildes.<pre>{errors}</pre>',
        dropZoneTitle: 'Dateien hierher ziehen &hellip;',
        fileActionSettings: {
            removeTitle: 'Datei entfernen',
            uploadTitle: 'Datei hochladen',
            indicatorNewTitle: 'Noch nicht hochgeladen',
            indicatorSuccessTitle: 'Hochgeladen',
            indicatorErrorTitle: 'Upload Fehler',
            indicatorLoadingTitle: 'Hochladen ...'
        }
    };
})(window.jQuery);